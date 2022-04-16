pub mod robot {
    pub struct Robot {
        pub facing: i32,
        pub position: Position,
    }

    pub trait RobotActions {
        fn new() -> Robot {
            let facing = 0;
            let position = Position { x: 0, y: 0 };
            return Robot { facing, position };
        }

        fn where_iam(&self);

        fn make_step(&mut self, step: i32);

        fn make_multiple_steps(&mut self, steps: Vec<i32>);
    }

    impl RobotActions for Robot {
        fn where_iam(&self) {
            println!(
                "Iam located at: X: {} and Y: {}",
                self.position.x, self.position.y
            );
        }

        fn make_step(&mut self, step: i32) {
            if self.facing == 0 {
                self.position.y += step;
                self.facing = 1;
                return;
            }

            if self.facing == 1 {
                self.position.x += step;
                self.facing = 2;
                return;
            }

            if self.facing == 2 {
                self.position.y -= step;
                self.facing = 3;
                return;
            }

            if self.facing == 3 {
                self.position.x -= step;
                self.facing = 0;
                return;
            }
        }

        fn make_multiple_steps(&mut self, steps: Vec<i32>) {
            for step in steps.iter() {
                self.make_step(*step);
            }
        }
    }

    pub struct Position {
        pub x: i32,
        pub y: i32,
    }
}
