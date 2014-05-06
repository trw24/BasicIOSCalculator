//
//  CalculatorModel.h
//  BasicCalculator
//
//  Created by Troy Weidman on 6/9/13.
//  Copyright (c) 2013 Troy Weidman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject


// Class method to get Shared Model
+(CalculatorModel *) getCalculatorModel;

// Additional Class Methods
+(NSString *)       getTotalString;
+(NSString *)       getStatusString;


// Instance Methods
-(void)     userEntersDigit:(NSString *)userInput;
-(void)     userEntersFunction:(NSString *)userInput;
-(void)     userEntersClear;
-(void)     userEntersClearEntry;
-(void)     userEntersBackspace;
-(void)     userEntersEqual;
-(void)     doNothing;




@end





