//
//  TutorialViewController.swift
//  Lugares
//
//  Created by Felipe Hernandez on 20-08-17.
//  Copyright © 2017 kafecode. All rights reserved.
//

import UIKit

class TutorialViewController: UIPageViewController {
    
    var tutoriaSteps: [TutorialStep] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstStep = TutorialStep(index: 0, heading: "Personaliza", content: "Crea Nuevos Lugares y ubicalos con solo algunos pocos segundos.", image: #imageLiteral(resourceName: "tuto-intro-1"))
        tutoriaSteps.append(firstStep)
        
        let secondStep = TutorialStep(index: 1, heading: "Encuentra", content: "Ubica tus lugares favoritos a través del mapa.", image: #imageLiteral(resourceName: "tuto-intro-2"))
        tutoriaSteps.append(secondStep)
        
        let thirdStep = TutorialStep(index: 2, heading: "Descubre", content: "Descubre lugares increibles cerca de ti y compartelo con tus amigos.", image: #imageLiteral(resourceName: "tuto-intro-3"))
        tutoriaSteps.append(thirdStep)
        
        dataSource = self
        
        if let startVC = self.PageViewController(atIndex: 0){
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func forward(toIndex: Int){
        
        if let nextVC = self.PageViewController(atIndex: toIndex + 1){
            self.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    
    }


}

//configura la informacion que contendrá
extension TutorialViewController: UIPageViewControllerDataSource{

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        index += 1
        
        
        return self.PageViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TutorialContentViewController).tutorialStep.index
        index -= 1

        return self.PageViewController(atIndex: index)
    }
    
    //metodo auxiliar
    func PageViewController(atIndex: Int) -> TutorialContentViewController?{
        
        if atIndex == NSNotFound || atIndex < 0 || atIndex >= self.tutoriaSteps.count{
            return nil
        }
        
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughPageContent") as? TutorialContentViewController{
        
            pageContentViewController.tutorialStep = self.tutoriaSteps[atIndex]
            
            return pageContentViewController
        
        }
        
        return nil
        
    
    }
    
    
    /*
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.tutoriaSteps.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        if let pageContenVC = storyboard?.instantiateViewController(withIdentifier: "WalkthroughPageContent") as? TutorialContentViewController{
            
            if let tutorialStep = pageContenVC.tutorialStep{
                return tutorialStep.index
            }
            
        }
        
        return 0
    }*/
    
    
}
