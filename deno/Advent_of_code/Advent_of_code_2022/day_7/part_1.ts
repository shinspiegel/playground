class File {
  public name: string;
  public parent: Directory;
  public size: number;

  constructor(name: string, parent: Directory, size: number) {
    this.name = name;
    this.parent = parent;
    this.size = size;
  }
}

class Directory {
  public name: string;
  public parent?: Directory;
  public children: (Directory | File)[] = [];
  public totalSize = 0;

  constructor(name: string, parent?: Directory) {
    this.parent = parent;
    this.name = name;
  }

  public sort() {
    this.children.sort((a, b) => {
      if (a instanceof Directory && b instanceof Directory) return 0;
      if (a instanceof File && b instanceof File) return 0;
      if (a instanceof Directory && b instanceof File) return -1;
      if (b instanceof Directory && a instanceof File) return 1;
      return 0;
    });
  }

  public calculateSize() {
    this.sort();

    this.children.forEach((child) => {
      if (child instanceof Directory) {
        child.calculateSize();
        this.totalSize += child.totalSize;
        return;
      }

      if (child instanceof File) {
        this.totalSize += child.size;
        return;
      }
    });
  }
}

export class FileSystem {
  public debug?: boolean;
  public print?: boolean;
  public head: number;
  public logs: string[];
  public root: Directory;
  public currentDir: Directory;
  public unusedSpace = 0;

  constructor(logs: string[], { debug, print }: { print?: boolean; debug?: boolean } = {}) {
    if (this.debug) console.log("DEBUG::constructor      ", { logs });
    this.logs = logs;
    this.head = 0;
    this.process();
    this.calculateStorage();
    this.unusedSpace = 70000000 - this.root.totalSize;
    this.debug = debug;
    this.print = print;

    if (this.print) {
      this.printTree();
    }
  }

  public solveOne(size: number, folder?: Directory): number {
    if (!folder) {
      return this.solveOne(size, this.root);
    }

    let total = 0;

    folder.children.forEach((child) => {
      if (child instanceof Directory) {
        total += this.solveOne(size, child);
      }
    });

    if (folder.totalSize < size) {
      total += folder.totalSize;
    }

    return total;
  }

  public solveTwo(folder?: Directory): Directory[] {
    if (!folder) {
      return this.solveTwo(this.root);
    }

    const list: Directory[] = [folder];

    folder.children.forEach((child) => {
      if (child instanceof Directory) {
        list.push(...this.solveTwo(child));
      }
    });

    return list;
  }

  private printTree(entry?: Directory | File, level = 0) {
    const space = new Array(level * 2).fill(" ").join("");

    if (!entry) {
      this.printTree(this.root);
    }

    if (entry instanceof File) {
      console.log(`${space}|-${entry.name} (File - ${entry.size})`);
      return;
    }

    if (entry instanceof Directory) {
      console.log(`${space}|-${entry.name} (Dir - ${entry.totalSize})`);

      entry.sort();

      entry.children.forEach((child) => {
        this.printTree(child, level + 1);
      });
    }
  }

  private process() {
    const command = this.logs[this.head];
    if (this.debug) console.log("DEBUG::process   ", { command });

    const [type, argument] = command.slice(2).split(" ");
    if (this.debug) console.log("DEBUG::process   ", { type, argument });

    if (type === "cd") this.changeDir(argument);
    if (type === "ls") this.list();

    this.moveHead();

    if (this.logs[this.head]) {
      this.process();
    }
  }

  private changeDir(address: string) {
    if (this.debug) console.log("DEBUG::changeDir ", { address });

    if (address === "/") {
      const root = new Directory("/");
      this.root = root;
      this.currentDir = root;
      return;
    }

    if (address === "..") {
      const parent = this.currentDir.parent;
      if (!parent) throw new Error("Failed to locate the parent directory");
      this.currentDir = parent;
      return;
    }

    const childDir = this.currentDir.children.find((f) => f.name === address);

    if (childDir && childDir instanceof Directory) {
      this.currentDir = childDir;
      return;
    }

    throw new Error(`Address not found [${address}]`);
  }

  private moveHead(amount = 1) {
    if (this.debug) console.log("DEBUG::moveHead  ", { head: this.head, next: this.head + amount });
    this.head += amount;
  }

  private list() {
    const nextLine = this.logs[this.head + 1];
    if (this.debug) console.log("DEBUG::list      ", { nextLine });

    if (!nextLine || nextLine.startsWith("$")) {
      return;
    }

    if (nextLine.startsWith("dir")) {
      const [_, path] = nextLine.split(" ");
      const newDir = new Directory(path, this.currentDir);
      this.currentDir.children.push(newDir);
    } else {
      const [size, filename] = nextLine.split(" ");
      const newFile = new File(filename, this.currentDir, parseInt(size));
      this.currentDir.children.push(newFile);
    }

    this.moveHead();
    this.list();
  }

  private calculateStorage() {
    this.root.calculateSize();
  }
}
