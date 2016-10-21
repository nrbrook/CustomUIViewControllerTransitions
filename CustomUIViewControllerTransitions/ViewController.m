//
//  ViewController.m
//  CustomUIViewControllerTransitions
//
//  Created by Nick Brook on 20/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"

#import "FadeTransition.h"
#import "FadePopTransition.h"

@interface ViewController ()

@property(nonatomic, strong) FadeTransition *fadeTransition;
@property(nonatomic, strong) FadePopTransition *fadePopTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we must maintain a strong reference to transitions, otherwise they will not occur on dismiss.
    self.fadeTransition = [FadeTransition new];
    self.fadePopTransition = [FadePopTransition new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    BaseTransition *transition;
    if([segue.identifier isEqualToString:@"fade"]) {
        transition = self.fadeTransition;
    } else if([segue.identifier isEqualToString:@"fadePop"]) {
        transition = self.fadePopTransition;
    }
    
    if(transition) {
        segue.destinationViewController.transition = transition;
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

@end
