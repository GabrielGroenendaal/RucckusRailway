import { connect } from "react-redux";

import ServerPublicForm from "./server_public_form";
import { openModal, closeModal } from "../../../actions/modal_actions";

const mapDispatchToProps = dispatch => {
  return {
    openModal: modal => dispatch(openModal(modal)),
    closeModal: () => dispatch(closeModal())
  }
}

export default connect(null, mapDispatchToProps)(ServerPublicForm);