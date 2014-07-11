//
//  CalculatorModel.m
//  BasicCalculator
//
//  Created by Troy Weidman on 6/9/13.
//  Copyright (c) 2013 Troy Weidman. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel ()

@property (nonatomic)           BOOL    isEnteringNumber;

@property (nonatomic, strong) NSString * currentTotalString;
@property (nonatomic, strong) NSString * previousTotalString;
@property (nonatomic, strong) NSString * pendingFunctionString;
@property (nonatomic, strong) NSString * statusMessageString;

@end




@implementation CalculatorModel


-(void)     userEntersEqual
{
    int     currentNumber   = [self.currentTotalString intValue];
    int     previousNumber  = [self.previousTotalString intValue];
    int     newTotalNumber  = 0;
    BOOL    isIntegerResult = YES;
    double  nonIntegerNumber = 0.0;

    self.isEnteringNumber = NO;
    
         if ([self.pendingFunctionString isEqualToString:@"+"])  newTotalNumber = previousNumber + currentNumber;
    else if ([self.pendingFunctionString isEqualToString:@"-"])  newTotalNumber = previousNumber - currentNumber;
    else if ([self.pendingFunctionString isEqualToString:@"X"])  newTotalNumber = previousNumber * currentNumber;
    else if ([self.pendingFunctionString isEqualToString:@"/"])
    {
        if (currentNumber != 0)
        {
            newTotalNumber = previousNumber / currentNumber;

            if ( (newTotalNumber * currentNumber) == previousNumber)    isIntegerResult = YES;
            else                                                        isIntegerResult = NO;
            
            self.statusMessageString = @"";
        }
        else
        {
            // Display Message:  Can not divide by Zero
            self.statusMessageString = @"Sorry.  Cannot divide by Zero.";
            self.currentTotalString = @"0";
            self.previousTotalString = @"0";
            self.pendingFunctionString = @"";
            return;
        }
    }
    else
    {
        self.statusMessageString = @"Don't know that function.";
    }
    
    if (isIntegerResult == YES)
    {
        self.currentTotalString = [NSString stringWithFormat:@"%d", newTotalNumber];
    }
    else
    {
        nonIntegerNumber = (1.0 * previousNumber) / currentNumber;
        self.currentTotalString = [NSString stringWithFormat:@"%f", nonIntegerNumber];
    }

    self.previousTotalString = @"0";
    self.pendingFunctionString = @"";    
}


-(void)     userEntersDigit:(NSString *)userInput
{
    if (self.isEnteringNumber == NO)
    {
        self.isEnteringNumber = YES;
        self.currentTotalString = @"0";
    }

    if ([self.currentTotalString isEqualToString:@"0"])    // zero being displayed
    {
        
        if ([userInput  isEqualToString:@"0"])          // zero pressed
        {
            // in this case, do nothing
        }
        else
        {
            self.currentTotalString = userInput;       // set to newly typed digit
        }
    }
    else
    {
        self.currentTotalString = [self.currentTotalString stringByAppendingString:userInput];
    }
    self.statusMessageString = @"";
}


-(void)     userEntersFunction:(NSString *)userInput
{
    
    if ([self.pendingFunctionString length])
    {
        [self userEntersEqual];
    }

    self.pendingFunctionString = userInput;

    self.previousTotalString = self.currentTotalString;
    self.currentTotalString = @"0";
    self.statusMessageString = @"";
    self.isEnteringNumber = NO;
}


-(void)     userEntersClear
{
    self.pendingFunctionString = @"";
    self.previousTotalString = @"0";
    self.currentTotalString = @"0";
    self.statusMessageString = @"";
    self.isEnteringNumber = NO;
}


-(void)     userEntersClearEntry
{
    self.currentTotalString = @"0";
    self.statusMessageString = @"";
    self.isEnteringNumber = NO;
}


-(void)     userEntersBackspace
{
    int currentTotalStringLength = (int) self.currentTotalString.length;
    
    if (self.isEnteringNumber == NO)
    {
        return;
    }
    else
    {
        if (currentTotalStringLength > 1)
        {
            self.currentTotalString = [self.currentTotalString substringToIndex:(currentTotalStringLength - 1)];
        }
        else
        {
            self.currentTotalString = @"0";
        }
        self.statusMessageString = @"";
    }
}


-(void)     doNothing {};


+(NSString *)       getTotalString
{
    CalculatorModel * myCalculatorModel = [self getCalculatorModel];
    return (myCalculatorModel.currentTotalString);
}


+(NSString *)       getStatusString
{
    CalculatorModel * myCalculatorModel = [self getCalculatorModel];
    return (myCalculatorModel.statusMessageString);
}


+(CalculatorModel *) getCalculatorModel
{
    static CalculatorModel * _myModel;
    
    if (_myModel == nil)
    {
        _myModel = [[CalculatorModel alloc] init];
        _myModel.currentTotalString = @"0";
        _myModel.previousTotalString = @"0";
        _myModel.pendingFunctionString = @"";
        _myModel.statusMessageString = @"";
        _myModel.isEnteringNumber = NO;
    }
    
    return (_myModel);
}


@end





