## What is this?

If you've ever seen or made a custom animation by subclassing UIStoryboardSegue, there is a better way to do it. Since iOS 7 you can create a 'transition delegate', which controls the transition between view controllers. This project contains classes which make it easier to implement a custom transition, particularly if you are only wanting to animate UIView properties. There are also pre-built transitions which you can drop in and start using.

![Transition demo](Demo.gif?raw=true)

## Usage

If you are using Storyboard with segues, it's really simple. Just override `-prepareForSegue:` in your presenting view controller and set the transition:

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we must maintain a strong reference to transitions, otherwise they will not occur on dismiss.
    self.transition = [FadeTransition new];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if([segue.identifier isEqualToString:@"fade"]) {
        [self.transition setAsTransitionForViewController:segue.destinationViewController];
    }
}
```

Done!

You can also set a transition on a navigation controller, either by creating a transition object on your storyboard scene and setting the transition controller as delegate, or in code in the view controller which presents the nav controller:

```
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
    	UINavigationController *c = segue.destinationViewController;
        [self.transition setAsTransitionForNavigationController:c];
    }
}
```

## Adding transitions

See `FadeTransition` as an example. For UIView based animations, just subclass `UIViewPropertyTransition` and implement the three required animation methods in `UIViewPropertyTransitionSubclass`. Do not call `super`.

If you create new transitions, please submit a pull request!
