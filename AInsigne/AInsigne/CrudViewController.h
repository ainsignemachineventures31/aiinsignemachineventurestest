//
//  CrudViewController.h
//  AInsigne
//
//  Created by macbook on 4/14/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FireBaseHandler.h"
#import "ViewController.h"
#import "ProjectsViewController.h"

@interface CrudViewController : UIViewController
@property (strong, nonatomic) IBOutlet NSString *userName;
@property (strong, nonatomic) IBOutlet UITextField *jobField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *specialtiesField;
- (void)disableButton:(UIButton *)btn disable:(BOOL)disable;
- (IBAction)update:(id)sender;
- (IBAction)create:(id)sender;
- (IBAction)del:(id)sender;
- (void)disableAll;
- (void)refreshFields;
- (void)refreshProfile;
- (IBAction)goBack:(id)sender;
- (IBAction)viewProj:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *createBtn;
@property (strong, nonatomic) IBOutlet UIButton *updBtn;
@property (strong, nonatomic) IBOutlet UIButton *delBtn;


@end
