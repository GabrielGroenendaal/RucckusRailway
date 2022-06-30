import React from "react";


const ModalCloseButton = (props) => {
      return (
            <svg
                  className="close-button"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  onClick={() => props.closeModal()}
            ><path fill="currentColor" d="M18.4 4L12 10.4L5.6 4L4 5.6L10.4 12L4 18.4L5.6 20L12 13.6L18.4 20L20 18.4L13.6 12L20 5.6L18.4 4Z"></path>
            </svg>
      )
}

export default ModalCloseButton;