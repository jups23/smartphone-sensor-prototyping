//
//  MGKeyboardViewController.h
//  Parsnip
//
//  Created by Willi Müller on 11.04.14.
//  Copyright (c) 2014 UFMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGCodeViewController.h"

@interface MGKeyboardViewController : UICollectionViewController

-(void)registerCodeViewController:(MGCodeViewController *) codeVC;

@end
