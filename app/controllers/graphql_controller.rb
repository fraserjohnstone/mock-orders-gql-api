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

  def available_session_response
    {
      "data": {
        "getPanelInvitation": {
          "email": "participant@usertesting.dev",
          "currentLocale": "en-US",
          "displayName": "Person Name",
          "dashboardUrl": "http://localhost:3000/my_dashboard",
          "unsubscribeUrl": "http://localhost:3000/unsubscribe?id=etc",
          "availableSession": {
            "panelTitle": "Dynademo Panel",
            "compensationAmount": 10,
            "otherRequirement": nil,
            "nextScreenerQuestion": nil,
            "panel": {
              "title": "Our Panel",
              "type": "my_panel",
              "brandingAsset": {
                "presignedUrl": "https://a_long_url.com/image.png"
              }
            }
          }
        }
      }
    }.to_json
  end
end
