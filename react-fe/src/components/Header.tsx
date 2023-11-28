import React from 'react';
import {Link} from 'react-router-dom';
import '../styles/header.css';



export const Header = () => {
  const userId = 1;

  return (
    <div className='Header'>
      <Link to="/home"><img className='header_icons' src="https://cdn-icons-png.flaticon.com/128/3917/3917032.png" alt="" /></Link>
      <input className='search_bar' type="text" placeholder="Search" />
      <Link to={`profile/${userId}`}><img className='header_icons' src="https://cdn-icons-png.flaticon.com/128/3917/3917711.png" alt="" /></Link>
    </div>
  );
};
