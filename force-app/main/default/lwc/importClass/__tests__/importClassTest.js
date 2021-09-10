import {classA} from '../classA';

it('should set up the class constructor', () => {
    const object = new classA('Jason');
    expect(object.name).toBe('Jason');
});

it('should console log a sentence containing a name', () => {
    console.log = jest.fn();
    const object = new classA('Jason');
    object.printName();
    expect(console.log).toHaveBeenCalledWith('Hello, my name is: Jason');
});
