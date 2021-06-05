class GraphqlController < ApplicationController
  def execute
    render json: response_for(operation: params[:operationName])
  end
  
  private
  
  def response_for(operation:)
    case operation
    when "getAvailableSessionForParticipant"
      available_session_response
    when "getPanelInvitation"
      panel_invitation_response
    end
  end

  def panel_invitation_response
    {
      "data": {
        "getPanelInvitation": {
          "confirmationMailerView": {
            "uuid": SecureRandom.uuid,
            "brandingAssetUrl": "https://via.placeholder.com/300x125",
            "userEmail": "participant@usertesting.dev",
            "hasCustomerBranding": true,
            "testerFacingName": "Create Great Experiences with UserTesting!",
            "panelTitle": "Participants who are awesome!"
          }
        }
      }
    }.to_json
  end
end
