export class classA {
    hello = 'Hello, my name is: ';

    constructor(name) {
        this.name = name;
    }

    printName() {
        console.log(this.hello + this.name);
    }
}