import {LightningElement} from 'lwc';
import {classA} from "./classA";

export default class ImportClass extends LightningElement {
    classA = new classA('Jason');

    handleOnClick(event) {
        this.classA.printName()
    }
}