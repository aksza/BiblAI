import React from 'react';
import {Link} from 'react-router-dom';
import '../styles/header.css';
import { useState, useEffect } from 'react';
import { useUser } from '../services/userContext';



export const Header = () => {
  const user = useUser();

  const [token, setToken] = useState<string | null>(null);
  const deleteToken = () => {
    localStorage.removeItem('token')
    setToken(null)
    console.log('token deleted')
    window.location.href = '/login';
  }

  useEffect(() => {
    const storedToken = localStorage.getItem('token');
    if (storedToken) {
      setToken(storedToken);
    }
  }, []);

  return (
    <div className='Header'>
      <Link to={`/home`}><i className="fi fi-rs-home"></i></Link>
      <input className='search_bar' type="text" placeholder="Search" />
      <div>
        {!token ?
        <>
        <Link to='/login'><p>Log In</p></Link>
        <Link to='/question'><i className="fi fi-br-plus"></i></Link>
        </>
        : 
        <div className='header_right_side'>
        <Link to='/question'><i className="fi fi-br-plus"></i></Link>
        <i className="fi fi-rs-exit" onClick={deleteToken}></i>
        <Link to={`profile/${user.user.id}`}><img src={user.user.profilePictureUrl} alt='' /></Link>
        </div>
        }
      </div>
    </div>
  );
};
