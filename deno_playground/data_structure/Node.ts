export class DoubleNode<T> {
    constructor(
        public value: T,
        public next: DoubleNode<T> | null = null,
        public prev: DoubleNode<T> | null = null
    ) {}
}

export class SimpleNode<T> {
    constructor(public value: T, public next: SimpleNode<T> | null = null) {}
}
