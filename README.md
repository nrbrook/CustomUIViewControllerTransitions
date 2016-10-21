## What is this?

If you've ever seen or made a custom animation by subclassing UIStoryboardSegue, there is a better way to do it. Since iOS 7 you can create a 'transition delegate', which controls the transition between view controllers. This project contains classes which make it easier to implement a custom transition, particularly if you are only wanting to animate UIView properties. There are also pre-built transitions which you can drop in and start using.

![Transition demo](Demo.gif?raw=true)

## Usage

Just set the transition to the view controller you are transitioning to:

```
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if([segue.identifier isEqualToString:@"fade"]) {
        segue.destinationViewController.transition = [FadeTransition new];
    }
}
```

Done!

You can also set a transition between all view controllers in a navigation controller:

```
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
    	UINavigationController *c = segue.destinationViewController;
        c.stackTransition = [FadeTransition new];
    }
}
```

Note that this sets the Navigation Controller's delegate property. If you want your class to be the delegate, instead of setting the `stackTransition` property just implement the `-navigationController:animationControllerForOperation:fromViewController:toViewController:` and return a transition object.

## Adding transitions

See `FadeTransition` as an example. For UIView based animations, just subclass `UIViewPropertyTransition` and implement the three required animation methods in `UIViewPropertyTransitionSubclass` protocol. Do not call `super`.

If you create new transitions, please submit a pull request!
