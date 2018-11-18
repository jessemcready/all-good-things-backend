class Api::V1::RelationshipsController < ApplicationController

  def index
    render json: @relationships, each_serializer: RelationshipSerializer, status: :ok
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      render json: RelationshipSerializer.new(@relationship), status: :created
    else
      render json: { errors: @relationship.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @relationship = Relationship.find_by(relationship_params)
    @relationship.destroy
    render json: { message: 'deleted' }, status: :ok
  end

  private

  def relationship_params
    params.require(:relationship).permit(:follower_id, :followee_id)
  end

end
