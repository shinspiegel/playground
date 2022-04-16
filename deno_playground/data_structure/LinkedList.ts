import { SimpleNode as Node } from "./Node.ts";

export default class LinkedList<T> {
    constructor(
        private head: Node<T> | null = null,
        private count: number = 0
    ) {}

    public showList() {
        let current = this.head;

        while (current !== null) {
            console.log("Current: ", current.value);
            current = current.next;
        }
    }

    public insertFirst(value: T) {
        const newNode = new Node(value);
        this.count += 1;

        if (!this.head) {
            this.head = newNode;
            return;
        }

        newNode.next = this.head;
        this.head = newNode;
    }

    public insertAt(position: Number, value: T) {
        const newNode = new Node<T>(value);

        let count = 0;
        let current: Node<T> | null = this.head;
        let previous: Node<T> | null = null;

        while (true) {
            if (count <= position) {
                if (count === position) {
                    if (previous) {
                        previous.next = newNode;
                    }

                    newNode.next = current;
                    this.count += 1;
                    return null;
                }

                count += 1;

                if (current?.next) {
                    previous = current;
                    current = current.next;
                }
            } else {
                return null;
            }
        }
    }

    public deleteFirst() {
        if (!this.head) return;
        this.count -= 1;
        this.head = this.head.next;
    }

    public get(position: Number) {
        let count = 0;
        let current: Node<T> | null = this.head;

        while (true) {
            if (count <= position) {
                if (count === position) {
                    return current;
                }

                count += 1;

                if (current?.next) {
                    current = current.next;
                }
            } else {
                return null;
            }
        }
    }
}
