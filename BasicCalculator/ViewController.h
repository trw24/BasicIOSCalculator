//
//  ViewController.h
//  BasicCalculator
//
//  Created by Troy Weidman on 6/9/13.
//  Copyright (c) 2013 Troy Weidman. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ViewController : UIViewController


@property (weak, nonatomic)   IBOutlet UILabel                      *totalLabel;
@property (weak, nonatomic)   IBOutlet UILabel                      *statusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray  *allDigitButtons;


@end





