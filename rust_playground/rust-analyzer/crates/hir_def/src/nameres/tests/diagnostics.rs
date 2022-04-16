use base_db::fixture::WithFixture;
use test_utils::mark;

use crate::test_db::TestDB;

fn check_diagnostics(ra_fixture: &str) {
    let db: TestDB = TestDB::with_files(ra_fixture);
    db.check_diagnostics();
}

#[test]
fn unresolved_import() {
    check_diagnostics(
        r"
        use does_exist;
        use does_not_exist;
          //^^^^^^^^^^^^^^ unresolved import

        mod does_exist {}
        ",
    );
}

#[test]
fn unresolved_import_in_use_tree() {
    // Only the relevant part of a nested `use` item should be highlighted.
    check_diagnostics(
        r"
        use does_exist::{Exists, DoesntExist};
                               //^^^^^^^^^^^ unresolved import

        use {does_not_exist::*, does_exist};
           //^^^^^^^^^^^^^^^^^ unresolved import

        use does_not_exist::{
            a,
          //^ unresolved import
            b,
          //^ unresolved import
            c,
          //^ unresolved import
        };

        mod does_exist {
            pub struct Exists;
        }
        ",
    );
}

#[test]
fn unresolved_extern_crate() {
    check_diagnostics(
        r"
        //- /main.rs crate:main deps:core
        extern crate core;
          extern crate doesnotexist;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^ unresolved extern crate
        //- /lib.rs crate:core
        ",
    );
}

#[test]
fn extern_crate_self_as() {
    mark::check!(extern_crate_self_as);
    check_diagnostics(
        r"
        //- /lib.rs
          extern crate doesnotexist;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^ unresolved extern crate
        // Should not error.
        extern crate self as foo;
        struct Foo;
        use foo::Foo as Bar;
        ",
    );
}

#[test]
fn dedup_unresolved_import_from_unresolved_crate() {
    check_diagnostics(
        r"
        //- /main.rs crate:main
        mod a {
            extern crate doesnotexist;
          //^^^^^^^^^^^^^^^^^^^^^^^^^^ unresolved extern crate

            // Should not error, since we already errored for the missing crate.
            use doesnotexist::{self, bla, *};

            use crate::doesnotexist;
              //^^^^^^^^^^^^^^^^^^^ unresolved import
        }

        mod m {
            use super::doesnotexist;
              //^^^^^^^^^^^^^^^^^^^ unresolved import
        }
        ",
    );
}

#[test]
fn unresolved_module() {
    check_diagnostics(
        r"
        //- /lib.rs
        mod foo;
          mod bar;
        //^^^^^^^^ unresolved module
        mod baz {}
        //- /foo.rs
        ",
    );
}

#[test]
fn inactive_item() {
    // Additional tests in `cfg` crate. This only tests disabled cfgs.

    check_diagnostics(
        r#"
        //- /lib.rs
          #[cfg(no)] pub fn f() {}
        //^^^^^^^^^^^^^^^^^^^^^^^^ code is inactive due to #[cfg] directives: no is disabled

          #[cfg(no)] #[cfg(no2)] mod m;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ code is inactive due to #[cfg] directives: no and no2 are disabled

          #[cfg(all(not(a), b))] enum E {}
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ code is inactive due to #[cfg] directives: b is disabled

          #[cfg(feature = "std")] use std;
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ code is inactive due to #[cfg] directives: feature = "std" is disabled
        "#,
    );
}

/// Tests that `cfg` attributes behind `cfg_attr` is handled properly.
#[test]
fn inactive_via_cfg_attr() {
    mark::check!(cfg_attr_active);
    check_diagnostics(
        r#"
        //- /lib.rs
          #[cfg_attr(not(never), cfg(no))] fn f() {}
        //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ code is inactive due to #[cfg] directives: no is disabled

          #[cfg_attr(not(never), cfg(not(no)))] fn f() {}

          #[cfg_attr(never, cfg(no))] fn g() {}
        "#,
    );
}
