import { DoubleNode } from "./Node.ts";

export default class Stack<T> {
    constructor(
        private head: DoubleNode<T> | null = null,
        private count: number = 0
    ) {}

    insert(value: T) {
        const newNode = new DoubleNode(value);

        if (!this.head) {
            this.head = newNode;
        } else {
            this.head.prev = newNode;
            newNode.next = this.head;
            this.head = newNode;
        }
    }

    size(): number {
        return this.count;
    }

    remove(): T | undefined {
        if (this.head) {
            const currentHead = this.head;

            if (this.head.next) {
                this.head = this.head.next;
                this.head.prev = null;
            } else {
                this.head = null;
            }

            return currentHead.value;
        }
    }

    peek(): T | undefined {
        if (this.head) {
            return this.head.value;
        }
    }
}
