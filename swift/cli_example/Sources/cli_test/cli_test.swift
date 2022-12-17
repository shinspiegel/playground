@main
public struct cli_test {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(cli_test().text)
    }
}
