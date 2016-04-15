//
//  ViewController.h
//  AInsigne
//
//  Created by macbook on 4/14/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FireBaseHandler.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userField;
@property (strong, nonatomic) IBOutlet UITextField *passField;
- (IBAction)login:(id)sender;
- (IBAction)signUp:(id)sender;


@end

