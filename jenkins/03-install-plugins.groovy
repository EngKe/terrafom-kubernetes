import jenkins.*
import hudson.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;
import hudson.model.*
import jenkins.model.*
import hudson.security.*

final List<String> REQUIRED_PLUGINS = [
        "workflow-aggregator",
]

if (Jenkins.instance.pluginManager.plugins.collect {
  it.shortName
}.intersect(REQUIRED_PLUGINS).size() != REQUIRED_PLUGINS.size()) {
  REQUIRED_PLUGINS.collect {
    Jenkins.instance.updateCenter.getPlugin(it).deploy()
  }.each {
    it.get()
  }
  println 'Run this script again after restarting to create the jobs!'
}

println "Plugins were installed successfully"