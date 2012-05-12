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
#import "EditarContatosController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController ()

@end

@implementation ViewController


@synthesize contatos = _contatos;
@synthesize contatoSelecionado = _contatoSelecionado;

-(void) viewDidLoad{
    
    self.title = @"Contatos";
    UIBarButtonItem *btAdd = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeFormulario)];
    self.navigationItem.rightBarButtonItem = btAdd;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(exibeMaisAcoes:)];
    
    [self.tableView addGestureRecognizer:longPress];
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
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = c.nome;
    cell.detailTextLabel.text = c.email;
    return cell;
}

-(void)contatoAlteradoComSucesso{
    [self.tableView reloadData];
}

-(void)salvaContato:(Contato *)c{
    [self.contatos addObject:c];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Contato *c = [self.contatos objectAtIndex:indexPath.row];
    EditarContatosController *ecc = [[EditarContatosController alloc]initWithContato:c];
    
    ecc.delegate = self;
    
    [self.navigationController pushViewController:ecc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) exibeMaisAcoes:(UIGestureRecognizer *)gesto{
    if (gesto.state == UIGestureRecognizerStateBegan){
        CGPoint ponto = [gesto locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:ponto];
        Contato *contato = [self.contatos objectAtIndex:index.row];
        
        self.contatoSelecionado = contato;
        
        UIActionSheet *opcoes = [[UIActionSheet alloc] initWithTitle:contato.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar Email", @"Visualizar site", @"Abrir Mapa", nil];
        [opcoes showInView:self.view];
        
    }
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;            
        case 2:
            [self abrirSite];
            break;            
        case 3:
            [self mostrarMapa];
            break;            
        default:
            break;
    }
}

-(void) abrirAplicationComURL:(NSString *) url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void) ligar{
    UIDevice *device = [UIDevice currentDevice];
    if([device.model isEqualToString:@"iPhone"]){
        NSString *numero = [NSString stringWithFormat:@"tel:%@", self.contatoSelecionado.telefone];
        [self abrirAplicationComURL:numero];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Impossivel fazer ligacao" message:@"Seu dispositivo nao e um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

-(void) enviarEmail{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *enviadoEmail = [[MFMailComposeViewController alloc]init];
        enviadoEmail.mailComposeDelegate = self;
        [enviadoEmail setToRecipients:[NSArray arrayWithObject:self.contatoSelecionado.email]];
        [enviadoEmail setSubject:@"Caelum"];
        
        [self presentModalViewController:enviadoEmail animated:YES];       
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ops" message:@"You connot send an email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) abrirSite{
    NSString *url = self.contatoSelecionado.site;
    [self abrirAplicationComURL:url];
}

-(void) mostrarMapa{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", self.contatoSelecionado.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicationComURL:url];
}

@end
