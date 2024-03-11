class BirdsController < ApplicationController
  def show
    node_ids = params[:ids]
    birds = get_birds(node_ids)

    response = {
      birds: birds,
    }

   render json: response
  end

  private

  def get_birds(node_ids, birds = [], visited_nodes = Set.new)
    Node.includes(:birds, :children).where(id: node_ids).each do |node|
      unless visited_nodes.include?(node.id)
        birds.concat(node.birds.ids)
        visited_nodes << node.id

        children_to_query = node.children.ids - visited_nodes.to_a
        birds.concat(get_birds(children_to_query, [], visited_nodes)) if children_to_query.present?
      end
    end

    birds
  end
end
