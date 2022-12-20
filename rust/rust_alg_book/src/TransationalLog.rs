use std::cell::RefCell;
use std::rc::Rc;

mod TransationalLog {
    type SingleLink = Option<Rc<RefCell<Node>>>;

    #[derive(Clone, Debug)]
    pub struct Node {
        value: String,
        next: SingleLink,
    }

    impl Node {
        fn new(value: String) -> Rc<RefCell<Node>> {
            Rc::new(RefCell::new(Node {
                value: value,
                next: None,
            }))
        }
    }

    pub struct TransactionLog {
        head: SingleLink,
        tail: SingleLink,
        pub length: u64,
    }

    impl TransactionLog {
        pub fn new_empty() -> TransactionLog {
            TransactionLog {
                head: None,
                tail: None,
                length: 0,
            }
        }

        pub fn append(&mut self, value: String) {
            let node = Node::new(value);

            match self.tail.take() {
                Some(old) => old.borrow_mut().next = Some(node.clone()),
                None => self.head = Some(node.clone()),
            }

            self.length += 1;
            self.tail = Some(node);
        }

        pub fn pop(&mut self) -> Option<String> {
            self.head.take().map(|head| {
                if let Some(next) = head.borrow_mut().next.take() {
                    self.head = Some(next);
                } else {
                    self.tail.take();
                }

                self.length -= 1;

                return Rc::try_unwrap(head)
                    .ok()
                    .expect("Failed to try_unwrap")
                    .into_inner()
                    .value;
            })
        }
    }
}
