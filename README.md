# Delegates Protocols

## Delegate Pattern in Swift easy explained

Delegation is a very common Design Pattern in iOS. For beginners can be a bit difficult to understand at first. Here is a quick rundown to get it working quickly.

From the [swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html):

> Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action or to retrieve data from an external source without needing to know the underlying type of that source.

There is often an analogy with the boss and the intern.

I made a small example below. Our app has two screens. The first screen changes its colour based on the choice taken by the user on the second screen.
How do these two views communicate?

In this case, we can think of the first screen (the BaseScreen) as our intern waiting to be told what to do. The second screen ( the SelectionScreen) is the boss telling the first screen to change its colour.

The two ViewColtrollers are as a starting point:

#### The BaseScreen

``` swift
class BaseScreen: UIViewController {
    //this button will bring me to the SelectionScreen 
    @IBOutlet weak var chooseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        present(selectionVC, animated: true, completion: nil)
    }
}
```

#### The SelectionScreen

This view will show two buttons, pressing one of them will just dismiss the view controller and return to the BaseScreen.

``` swift
class SelectionScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func redButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func blueButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
```

#### The steps to implement the delegation pattern are:

- create a protocol with a function declaration. This function is only declared in the protocol. It will be called in the selection screen and will be implemented in the base screen.

```swift
protocol ColorChangeDelegate {
    func didChooseColor(color: UIColor)
}
```

- Our main screen, the base screen, will conform to that delegate protocol and implement the function declared in the protocol. 

```swift
extension BaseScreen: ColorChangeDelegate {
    func didChooseColor(color: UIColor) {
        view.backgroundColor = color
    }
}
```

So when the base screen will present the SelectionViewController, it will set itself as its delegate in the 

```
class BaseScreen: UIViewController {

    @IBOutlet weak var chooseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        let selectionVC = storyboard?.instantiateViewController(withIdentifier: "SelectionScreen") as! SelectionScreen
        // this is where we assign the base controller as the delegate of the next screen 
        selectionVC.colorDelegate = self
        present(selectionVC, animated: true, completion: nil)
    }
}

```
 
- The selection screen will call the delegate function when the button has been tapped but not implement what will happen in the implementation:


``` swift
class SelectionScreen: UIViewController {
    // this is the declaration of my delegate. It is unwrapped because it is initialised in the previous screen
    var colorDelegate: ColorChangeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func redButtonTapped(_ sender: UIButton) {
    // if I tap this button I call the method didChooseColor(color:) on my delegate 
    // Guess who is the delegate? Thats right, BaseScreen!
        colorDelegate.didChooseColor(color: .red)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func blueButtonTapped(_ sender: UIButton) {
    // same here as above
        colorDelegate.didChooseColor(color: .blue)
        dismiss(animated: true, completion: nil)
    }
}
```

Now tapping on one of the two button will dismiss the SelectionScreen and will change the color on the delegate view which is our BaseScreen. 

This was a very basic explanation. The code is on [GitHub](https://github.com/multitudes/Delegates-Protocols/tree/master)
I hope this simple example made things a bit clearer about delegation in Swift.
