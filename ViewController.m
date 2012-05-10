//
//  ViewController.m
//  FirstContacts
//
//  Created by ios2686 on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Contato.h"
#import "FormularioContatoControllerViewController.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize contatos = _contatos;

-(void) viewDidLoad{
    [super viewDidLoad];
    self.title = @"Contatos";
    UIBarButtonItem *btAdd = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
    self.navigationItem.rightBarButtonItem = btAdd;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.contatos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Contato *c = [[Contato alloc]init];
    c = [self.contatos objectAtIndex:sourceIndexPath.row];
    [self.contatos removeObjectAtIndex:sourceIndexPath.row];
    [self.contatos insertObject:c  atIndex:destinationIndexPath.row];    
    
}

-(void)exibeFormulario {
    FormularioContatoControllerViewController *form = [[FormularioContatoControllerViewController alloc]initWithNibName:@"FormularioContatoControllerViewController" bundle:[NSBundle mainBundle]];
    
    form.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:form];
        
    [self presentModalViewController:nav animated:YES];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contatos count];
}

-(UITableViewCell *)tableView:(UITableView *)tabela cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tabela dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]; 
    }
    Contato *c = [self.contatos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = c.nome;
    cell.detailTextLabel.text = c.email;
    return cell;
}

-(void)salvaContato:(Contato *)c{
    [self.contatos addObject:c];
    [self.tableView reloadData];
}

@end
