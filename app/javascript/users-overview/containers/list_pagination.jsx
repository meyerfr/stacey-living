import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { fetchUsers } from '../actions';

class ListPagination extends Component {

  getPagesRange = () => {
    const page = this.props.pagination.page
    const pages = this.props.pagination.pages

    const pagesRange = [];
    // if (props.pages >= 10) {
    const start = page >= 5 ? page - 5 : 0
    const end = page + 5 >= pages ? pages : page + 5
    for (let i = start; i < end+1; ++i) {
      pagesRange.push(i);
    }
    return pagesRange
  }
  // } else{

  //   for (let i = 0; i < props.pages+1; ++i) {
  //     pagesRange.push(i);
  //   }
  // }

  // const setPage = page => {
  //   props.onSetPage(page);
  // }

  setPage = (page = null) => {
    // console.log(page)
    this.props.fetchUsers(page, 'applicants', 'role')
  }

  render() {
    const pagesRange = this.getPagesRange()

    if (this.props.pagination.pages == 0) {
      return null;
    }

    return (
      <nav>
        <ul className="pagination">

          {
            pagesRange.map(v => {
              const isCurrent = v === this.props.pagination.page;
              const onClick = ev => {
                ev.preventDefault();
                this.setPage(v);
              };
              return (
                <li
                  className={ isCurrent ? 'page-item active' : 'page-item' }
                  onClick={onClick}
                  key={v.toString()}>

                  <a className="page-link" href="">{v + 1}</a>

                </li>
              );
            })
          }

        </ul>
      </nav>
    );
  }
};


function mapStateToProps(state) {
  return {
    pagination: state.pagination
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchUsers }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(ListPagination);
