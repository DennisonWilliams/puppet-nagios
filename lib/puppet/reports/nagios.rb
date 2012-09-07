require 'puppet'
require 'yaml'

Puppet::Reports.register_report(:nagios) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "nagios.yaml"])
  raise(Puppet::ParseError, "Nagios report config file #{configfile} does not exist.") unless File.exist?(configfile)
  CREDS = YAML.load_file(configfile)

	# TODO: check to make sure that the nsca_host is defined

  desc <<-DESC
  Send report information to Nagios using a custom Nagios application. 
  DESC

  def process
		# For all report status
		# Send a report to the nagios server via send_nsca that describes the 
		# puppet status

		# ie in perl:
		#open(NSCA, "|$NSCA -H $NSCA_HOST -c $NSCA_CONFIG") or
    #    die "could not start nsca: $NSCA -H $NSCA_HOST -c $NSCA_CONFIG";

		#my $RESULT=`$CHECK_GCAT_PORT`;
		#my $rc = ($?>>8);
		#print NSCA "mamawang\tCheck Global Catalog Port\t$rc\t$RESULT";

		#close NSCA;

		Puppet.debug "Opening: #{CREDS[:send_nsca]} -H #{CREDS[:nsca_host]} -c #{CREDS[:send_nsca_config]}"
		stdin, stdout, stderr = Open3.popen3("#{CREDS[:send_nsca]} -H #{CREDS[:nsca_host]} -c #{CREDS[:send_nsca_config]}") 
		# TODO: convert self.status to a nagios return code
		rc = self.status
		# TODO: create a map between names we get from puppet and names that are 
		# used in nagios.

		Puppet.debug "Sending: #{self.host}\tPuppet\t#{rc}\t#{self.status}"
		stdin.puts("#{self.host}\tPuppet\t#{rc}\t#{self.status}");

		# TODO: check stdout and stderr for messages
		stdin.close
		stdout.close
		stderr.close
  end
end
