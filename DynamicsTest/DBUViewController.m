//
//  DBUViewController.m
//  DynamicsTest
//
//  Created by David Bae on 2014. 4. 6..
//  Copyright (c) 2014년 David Bae. All rights reserved.
//

#import "DBUViewController.h"

@interface DBUViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIButton *fallingButton;
@property (strong, nonatomic) IBOutlet UIButton *danglingButton;
@property (strong, nonatomic) IBOutlet UIView *redSquare;
@property (strong, nonatomic) IBOutlet UITextView *resultTextView;

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior* gravityBeahvior;

@property (strong, nonatomic) UISnapBehavior *textFieldSnapBehavior;
@property (strong, nonatomic) UISnapBehavior *fallingButtonSnapBehavior;
@property (strong, nonatomic) UISnapBehavior *danglingButtonSnapBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *springBehavior;
@end

@implementation DBUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self.animator addBehavior:self.springBehavior];
    
    
    NSLog(@"gravity: %@", self.gravityBeahvior);
}
- (void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UISnapBehavior *)textFieldSnapBehavior
{
    if (_textFieldSnapBehavior == nil) {
        _textFieldSnapBehavior = [[UISnapBehavior alloc] initWithItem:self.textField snapToPoint:self.textField.center];
    }
    return _textFieldSnapBehavior;
}
- (UISnapBehavior *)fallingButtonSnapBehavior
{
    if (_fallingButtonSnapBehavior == nil) {
        _fallingButtonSnapBehavior = [[UISnapBehavior alloc] initWithItem:self.fallingButton snapToPoint:self.fallingButton.center];
    }
    return _fallingButtonSnapBehavior;
}
- (UISnapBehavior *)danglingButtonSnapBehavior
{
    if (_danglingButtonSnapBehavior == nil) {
        _danglingButtonSnapBehavior = [[UISnapBehavior alloc] initWithItem:self.danglingButton snapToPoint:self.danglingButton.center];
    }
    return _danglingButtonSnapBehavior;
}
- (UIAttachmentBehavior *)springBehavior
{
    if (_springBehavior == nil) {
        
        //_springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.danglingButton offsetFromCenter:UIOffsetMake(/*20.0f*/0, /*self.danglingButton.frame.size.height/2*/0) attachedToAnchor:CGPointMake(self.redSquare.center.x, self.redSquare.center.y)];
        //_springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.danglingButton attachedToItem:self.redSquare];
        _springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.danglingButton attachedToAnchor:CGPointMake(self.redSquare.center.x, self.redSquare.center.y)];
        [_springBehavior setFrequency:1.0f];
        [_springBehavior setDamping:0.1f];
    }
    return _springBehavior;
}

- (IBAction)startButton:(UIButton *)sender
{
    if (!self.gravityBeahvior) {
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [self.animator removeBehavior:self.textFieldSnapBehavior];
        [self.animator removeBehavior:self.fallingButtonSnapBehavior];
        [self.animator removeBehavior:self.danglingButtonSnapBehavior];
        
        [self.animator addBehavior:self.springBehavior];
        
        self.gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.fallingButton, self.textField]];
        [self.gravityBeahvior addItem:self.danglingButton];
        [self.animator addBehavior:self.gravityBeahvior];
    }else{
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [self.animator removeBehavior:self.gravityBeahvior];
        [self.animator removeBehavior:self.springBehavior];
        
        self.gravityBeahvior = nil;
        [self.animator addBehavior:self.textFieldSnapBehavior];
        [self.animator addBehavior:self.fallingButtonSnapBehavior];
        [self.animator addBehavior:self.danglingButtonSnapBehavior];
    }
    
    
    
    //self.animator removeBehavior:gravityBeahvior;
}

- (IBAction)danglingButton:(id)sender
{
    [self.resultTextView setText:[NSString stringWithFormat:@"%@\n%@", @"댕글링 버튼이 클릭되었어요.",self.resultTextView.text]];
}
- (IBAction)fallingButtonTouched:(id)sender
{
    [self.resultTextView setText:[NSString stringWithFormat:@"%@\n%@", @"떨어지는 버튼이 클릭되었어요.",self.resultTextView.text]];
}
#pragma mark -textouch Event Function
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}


@end
