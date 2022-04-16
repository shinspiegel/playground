use crate::robot::robot::*;

mod robot;

fn main() {
    let mut robot = Robot::new();
    robot.where_iam();
    robot.make_step(10);
    robot.where_iam();
    robot.make_step(10);
    robot.where_iam();
    robot.make_step(10);
    robot.where_iam();
    robot.make_step(10);
    robot.where_iam();

}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn make_some_steps() {
        let steps = vec![20, 30, 10, 40];
        let mut robot = Robot::new();
        robot.make_multiple_steps(steps);

        assert_eq!(robot.position.x, -10);
        assert_eq!(robot.position.y, 10);
    }

    #[test]
    fn make_no_step() {
        let steps = vec![];
        let mut robot = Robot::new();
        robot.make_multiple_steps(steps);

        assert_eq!(robot.position.x, 0);
        assert_eq!(robot.position.y, 0);
    }

    #[test]
    fn make_some_more_steps() {
        let steps = vec![-10, 20, 10];
        let mut robot = Robot::new();
        robot.make_multiple_steps(steps);

        assert_eq!(robot.position.x, 20);
        assert_eq!(robot.position.y, -20);
    }
}
