//
//  ProjectsViewController.h
//  AInsigne
//
//  Created by macbook on 4/15/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FireBaseHandler.h"
#import "CrudViewController.h"
@interface ProjectsViewController : UIViewController
@property (strong, nonatomic) IBOutlet NSString *userName;;
@property (strong, nonatomic) IBOutlet UIButton *createBtn;
@property (strong, nonatomic) IBOutlet UIButton *updateBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)createProj:(id)sender;
- (IBAction)updateProj:(id)sender;
- (IBAction)deleteProj:(id)sender;
- (IBAction)goBack:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *projName;
@property (strong, nonatomic) IBOutlet UITextField *projDesc;
@property (strong, nonatomic) IBOutlet UITextField *projDuration;

@property (strong, nonatomic) IBOutlet UITextField *projTech;

@property (strong, nonatomic) IBOutlet UIView *uiView;

- (IBAction)btnPrev:(id)sender;
- (IBAction)btnNext:(id)sender;



@end
