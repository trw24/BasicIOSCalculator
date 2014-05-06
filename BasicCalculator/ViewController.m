//
//  ViewController.m
//  BasicCalculator
//
//  Created by Troy Weidman on 6/9/13.
//  Copyright (c) 2013 Troy Weidman. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorModel.h"


@interface ViewController ()

-(void) updateDisplay;

@end




@implementation ViewController


- (IBAction)clearAllButton:(UIButton *)sender
{
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel userEntersClear];
    [self updateDisplay];
}


- (IBAction)clearEntryButton:(UIButton *)sender
{
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel userEntersClearEntry];
    [self updateDisplay];
}


- (IBAction)backspaceButton:(UIButton *)sender
{
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel userEntersBackspace];
    [self updateDisplay];
}


- (IBAction)functionButtonPressed:(UIButton *)sender
{
    
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel userEntersFunction:sender.titleLabel.text];
    [self updateDisplay];
}


- (IBAction)equalButtonPressed:(UIButton *)sender
{
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel userEntersEqual];
    [self updateDisplay];
}


- (IBAction)digitButtonPressed:(UIButton *)sender
{
    // NSLog(@"Button Title = %@", sender.titleLabel.text);
    
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel userEntersDigit:sender.titleLabel.text];
    [self updateDisplay];
}


-(void) updateDisplay
{
    self.totalLabel.text  = [CalculatorModel getTotalString];
    self.statusLabel.text = [CalculatorModel getStatusString];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CalculatorModel * myModel = [CalculatorModel getCalculatorModel];
    [myModel doNothing];
    [self updateDisplay];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
    self.statusLabel.text = @"didReceiveMemoryWarning";
}


-(NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAll);
    // This method needed if want to allow Portrait UpSideDown.
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIInterfaceOrientation currentOrientation = self.interfaceOrientation;
    
    // NSLog(@"%d ==> %d", fromInterfaceOrientation, currentOrientation);
    
    if (
        (currentOrientation == UIInterfaceOrientationLandscapeLeft) ||
        (currentOrientation == UIInterfaceOrientationLandscapeRight)
        )
    {
        // must make sure was coming from Portrait orientation
        if (
            (fromInterfaceOrientation == UIInterfaceOrientationPortrait) ||
            (fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            )
        {
            @try {
                        [self performSegueWithIdentifier:@"toLandscape" sender:self];
            }
            @catch (NSException *exception) {
                
                UIAlertView * myAlert = [[UIAlertView alloc]
                                         initWithTitle:@"Error"
                                         message:[exception reason]
                                         delegate:self
                                         cancelButtonTitle:@"Okay"
                                         otherButtonTitles:nil];
                [myAlert show];
            }
        }
    }
    else
        if (
            (currentOrientation == UIInterfaceOrientationPortrait  ) ||
            (currentOrientation == UIInterfaceOrientationPortraitUpsideDown)
            )
        {
            // make sure was coming from landscape orientation
            if (
                (fromInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||
                (fromInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
                )
            {
                @try {
                    
                    [self performSegueWithIdentifier:@"toPortrait" sender:self];
                }
                @catch (NSException *exception) {
                    
                    UIAlertView * myAlert = [[UIAlertView alloc]
                                             initWithTitle:@"Error"
                                             message:[exception reason]
                                             delegate:self
                                             cancelButtonTitle:@"Okay"
                                             otherButtonTitles:nil];
                    [myAlert show];
                }
            }
        }
        else
        {
            // NSLog(@"Well, that did not go so well");
            
            UIAlertView * myAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Error"
                                     message:@"Well, that did not go so well"
                                     delegate:self
                                     cancelButtonTitle:@"Okay"
                                     otherButtonTitles:nil];
            [myAlert show];
            
        }
}


@end







