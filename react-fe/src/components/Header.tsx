import React from 'react';
import {Link} from 'react-router-dom';
import '../styles/header.css';



export const Header = () => {
  const userId = 1;

  return (
    <div className='Header'>
      <Link to={`/home/${userId}`}><i className="fi fi-rs-home"></i></Link>
      <input className='search_bar' type="text" placeholder="Search" />
      <div>
        <Link to='/question'><i className="fi fi-br-plus"></i></Link>
        <Link to={`profile/${userId}`}><i className='fi fi-sr-user'></i></Link>
      </div>
    </div>
  );
};
