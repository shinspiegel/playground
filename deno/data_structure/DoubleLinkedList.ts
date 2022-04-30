import { DoubleNode as Node } from "./Node.ts";

export default class DoubleLinkedList<T> {
    constructor(
        private head: Node<T> | null = null,
        private tails: Node<T> | null = null,
        private count: number = 0
    ) {}

    insertFirst(value: T) {
        const newNode = new Node(value);

        if (this.head) {
            newNode.next = this.head;
            this.head.prev = newNode;
        }

        if (!this.tails) {
            this.tails = newNode;
        }

        this.head = newNode;
        this.count += 1;
    }

    removeFirst(): T | undefined {
        const current = this.head;

        if (this.head) {
            if (this.head.next) {
                this.head = this.head.next;
                this.head.prev = null;
            } else {
                this.head = null;
            }
        }

        return current?.value;
    }

    peekFirst(): T | undefined {
        return this.head?.value;
    }

    insertBack(value: T) {
        const newNode = new Node(value);

        if (this.tails) {
            newNode.prev = this.tails;
            this.tails.next = newNode;
        }

        if (!this.head) {
            this.head = newNode;
        }

        this.tails = newNode;
        this.count += 1;
    }

    removeBack(): T | undefined {
        const current = this.tails;

        if (this.tails) {
            if (this.tails.prev) {
                this.tails = this.tails.prev;
                this.tails.next = null;
            } else {
                this.tails = null;
            }
        }

        return current?.value;
    }

    peekBack(): T | undefined {
        return this.tails?.value;
    }

    showList(next: Node<T> | null = null) {
        if (!next) {
            next = this.head;
        }

        if (next) {
            console.log(next.value);

            if (next.next) {
                this.showList(next.next);
            }
        }
    }
}
