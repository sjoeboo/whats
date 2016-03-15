class Whats
  
  def self.config_find()
    config_search_paths=['~/.whats.yaml','/etc/whats.yaml']
    config_search_paths.each do |path|
    #If #{path} is a file and re can read it, return it.
      if File.exists?(File.expand_path(path))
        return (path)
      end
    end
    #no config found
    raise ("No config found!")
  end



  #if we passed shortname, get fqdn
  def self.domain_fix(host,domain,match)
  #Fix domain if needed
    if host.match(match)
      fqdn = host.to_s
    else
      fqdn = host.to_s + domain
    end
    return(fqdn)
  end

  #Query to see if the node we're looking for exists
  def self.node_test(puppetdb_host,puppetdb_port,fqdn)
    test_uri=URI.parse("http://#{puppetdb_host}:#{puppetdb_port}/pdb/query/v4/nodes/#{fqdn}")
    test_response = Net::HTTP.get_response(test_uri)
    test_body=JSON.parse(test_response.body)
    if test_body.key?("error")
      return false
    else
      return true
    end
  end

  #get all facts for the given node
  def self.get_facts(puppetdb_host,puppetdb_port,fqdn)
    uri=URI.parse("http://#{puppetdb_host}:#{puppetdb_port}/pdb/query/v4/nodes/#{fqdn}/facts")
    response = Net::HTTP.get_response(uri)
    facts=JSON.parse(response.body)
    return(facts)
  end

  #Parse the fact output from puppetdb into a simpler hash
  #
  # v4 apit returns facts as an array, with each element a hash like
  #{"certname"=>"some_host",
  #  "environment"=>"some_env",
  #  "name"=>"memorysize",
  #  "value"=>"3.70 GiB"},
  #
  def self.facts_to_hash(facts)
    node_facts=Hash.new
    facts.each do |fact|
      node_facts[fact["name"]] = fact["value"]
    end
    return node_facts
  end

#do output
  def self.output(options,facts2)
    #output time
    values=options[:basic_info]
    if options[:json] == true
      puts facts2.to_json
    elsif options[:yaml] == true
      puts facts2.to_yaml
    elsif options[:pp] == true
      pp facts2
    else
      table=Terminal::Table.new :headings => ['Fact', 'Value'], :rows => facts2
      puts table
    end
  end
end
