class Redshift < Mapper
  #
  # Returns an array of resources.
  #
  # TODO: test live
  #
  def collect
    resources = []

    #
    # describe_clusters
    #
    @client.describe_clusters.each_with_index do |response, page|
      log(response.context.operation_name, page)

      response.clusters.each do |cluster|
        struct = OpenStruct.new(cluster.to_h)
        struct.type = 'cluster'
        struc.arn = cluster.cluster_identifier

        resources.push(struct.to_h)
      end
    end

    #
    # describe_cluster_subnet_groups
    #
    @client.describe_cluster_subnet_groups.each_with_index do |response, page|
      log(response.context.operation_name, page)

      response.cluster_subnet_groups.each do |group|
        struct = OpenStruct.new(group.to_h)
        struct.type = 'subnet_group'
        struct.arn = group.cluster_subnet_group_name

        resources.push(struct.to_h)
      end
    end

    resources
  end
end
