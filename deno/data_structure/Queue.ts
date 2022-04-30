import { DoubleNode } from "./Node.ts";

export default class Queue<T> {
    constructor(
        private head: DoubleNode<T> | null = null,
        private tails: DoubleNode<T> | null = null,
        private count: number = 0
    ) {}

    insert(value: T): void {
        const newNode = new DoubleNode(value);

        if (!this.head) {
            this.head = newNode;
        }

        const currentTail = this.tails;

        if (currentTail) {
            currentTail.next = newNode;
            newNode.prev = newNode;
        }

        this.tails = newNode;
        this.count += 1;
    }

    peek(): T | undefined {
        if (this.head) {
            return this.head.value;
        }
    }

    remove(): T | undefined {
        if (this.head) {
            const currentHead = this.head;
            this.head = this.head.next;
            this.count -= 1;

            return currentHead.value;
        }
    }

    size(): number {
        return this.count;
    }
}
