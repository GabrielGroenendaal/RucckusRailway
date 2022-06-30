import React from "react";
import { Link } from "react-router-dom";
import { serverInitial } from "../../../util/server_api_util";


const ServerNavItems = props => {
   
      const defaultChannelId = Object.keys(props.server.channels)[0];
      const handleClick = () => {
            props.fetchServer(props.server.id)
            props.history.push(`/channels/${props.server.id}/${defaultChannelId}`)
      }

      return (
            <div
                  className="server-navigation-button"
                  onClick={() => { handleClick() }}>
                  {serverInitial(props.server)}
            </div>
      )
}

export default ServerNavItems;