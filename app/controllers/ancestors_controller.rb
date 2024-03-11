class AncestorsController < ApplicationController
  def show
    initialize_nodes
    analyze_nodes unless @nodes_equal

    response = {
      root_id: @root,
      lowest_common_ancestor: @common_ancestor,
      depth: @depth
    }

    render json: response
  end

  private

  def initialize_nodes
    @node_a = Node.find_by(id: params[:a])
    @node_b = Node.find_by(id: params[:b])

    if @node_a && @node_b
      @depth = 1

      if @node_a == @node_b
        @nodes_equal = true
        @common_ancestor = @node_a.id
        @root = get_root("a", [])
      else
        @node_a_ancestors = [@node_a.id]
        @node_b_ancestors = [@node_b.id]
        @count = 0
      end
    end
  end

  def analyze_nodes
    return unless @node_a && @node_b

    while (@node_a_ancestors & @node_b_ancestors).first.nil?
      @count.even? ? get_parent("a") : get_parent("b")
      @count += 1
    end

    @common_ancestor = (@node_a_ancestors & @node_b_ancestors).first
    # At this point both nodes should be set to the common ancestor, so it doesn't matter which one we send to the root method
    @root = get_root("a", @node_a_ancestors)
  end

  def get_root(node_type, array)
    node = instance_variable_get("@node_#{node_type}")

    if node.parent_id.present?
      @depth += 1
      instance_variable_set("@node_#{node_type}", node.parent)
      get_root(node_type, array + [node.parent_id])
    else
      node.id
    end
  end

  def get_parent(node_type)
    node = instance_variable_get("@node_#{node_type}")

    if node.parent_id
      instance_variable_get("@node_#{node_type}_ancestors") << node.parent_id
      instance_variable_set("@node_#{node_type}", node.parent)
    end
  end
end
