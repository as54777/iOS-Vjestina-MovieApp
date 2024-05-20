import UIKit

class LoginViewController: UIViewController {

    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginUI()
    }
        
    private func setupLoginUI() {
        usernameTextField = UITextField.newAutoLayout()
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.placeholder = "Username"
        
        passwordTextField = UITextField.newAutoLayout()
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .green
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        usernameTextField.autoAlignAxis(toSuperviewAxis: .vertical)
        usernameTextField.autoPinEdge(toSuperviewEdge: .top, withInset: 120)
        usernameTextField.autoSetDimensions(to: CGSize(width: 200, height: 40))
        
        passwordTextField.autoAlignAxis(toSuperviewAxis: .vertical)
        passwordTextField.autoPinEdge(.top, to: .bottom, of: usernameTextField, withOffset: 20)
        passwordTextField.autoSetDimensions(to: CGSize(width: 200, height: 40))
        
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 20)
        loginButton.autoSetDimensions(to: CGSize(width: 200, height: 40))
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        
        isLoggedIn = true
    }
}
