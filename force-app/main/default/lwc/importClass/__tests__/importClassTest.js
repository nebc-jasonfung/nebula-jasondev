import {classA} from '../classA';

it('should set up the class constructor', () => {
    const object = new classA('Jason');
    expect(object.name).toBe('Jason');
});

it('should console log a sentence containing a name', () => {
    console.log = jest.fn();
    const object = new classA('Jason');
    object.printName();
    expect(console.log.mock.calls[0][0]).toBe('Hello, my name is: Jason');
});
