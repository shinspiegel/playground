class Room {
    constructor(
        public name: string,
        public depth: number,
        public width: number
    ) {}

    public getArea() {
        return this.depth * this.width;
    }
}

class House {
    private constructor(private rooms: Room[]) {}

    public getHouseArea() {
        return this.rooms.reduce((acc, item) => acc + item.getArea(), 0);
    }

    public static builder() {
        return new (class HouseBuilder {
            private rooms: Room[] = [];

            build() {
                this.validate();
                return new House(this.rooms);
            }

            validate() {
                if (this.rooms.length <= 0) {
                    throw new Error("House must have at least one room");
                }

                if (this.rooms.length >= 5) {
                    throw new Error("House must have at least one room");
                }
            }

            addRoom(name: string, depth: number, width: number) {
                this.rooms.push(new Room(name, depth, width));
                return this;
            }
        })();
    }
}

const house = House.builder()
    .addRoom("Quarto 1", 3, 4)
    .addRoom("Quarto 2", 3, 4)
    .addRoom("Cozinha", 3, 4)
    .addRoom("Banheiro", 3, 4)
    .addRoom("Sala", 3, 4)
    .build();

console.log(house.getHouseArea());
