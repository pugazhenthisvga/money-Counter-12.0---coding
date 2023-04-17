
import UIKit

class ContainerViewController: UIViewController {
    var calculatorSegue : Int = 0
    var calculatorUnits : Int = 0
    var currentOption = "startCalculator"
    var currentParameters: [String: Any]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegue(withIdentifier: currentOption, sender: self)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    // MARK: - Segue and swapping view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nil { return }
        // set properties for Custom Split Content View Controllers
        // prepare segue VC swapping.
        if segue.identifier! == currentOption {
                self.addChild(segue.destination)
                segue.destination.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(segue.destination.view)
                segue.destination.didMove(toParent: self)
            
        }else {
            if segue.identifier == "inAppSegue"
            {
                let candyDetailViewController = segue.destination  as! ViewController
            }
        }
    }
}
 
