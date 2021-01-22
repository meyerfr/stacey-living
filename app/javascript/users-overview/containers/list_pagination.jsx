import React from 'react';

const ListPagination = props => {
  if (props.pages == 0) {
    return null;
  }

  const pagesRange = [];
  for (let i = 0; i < props.pages+1; ++i) {
    pagesRange.push(i);
  }

  const setPage = page => {
    props.onSetPage(page);
  }

  return (
    <nav>
      <ul className="pagination">

        {
          pagesRange.map(v => {
            const isCurrent = v === props.page;
            const onClick = ev => {
              ev.preventDefault();
              setPage(v);
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
};

export default ListPagination;
