import jenkins.model.*
import hudson.security.*

println "--> creating admin user"

def adminUsername = "admin"
def adminPassword = "changemepls"

assert adminUsername != null : "Username is not set"
assert adminPassword != null : "Password is not set"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(adminUsername, adminPassword)
Jenkins.instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
Jenkins.instance.setAuthorizationStrategy(strategy)

Jenkins.instance.save()