import {Uuser} from '../pages/Home'
import Axios from 'axios';
import { useState } from 'react';
import { useQuery } from "react-query"
import '../styles/profile_page.css'



export const Profile = () => {
  const [user, setUser] = useState<Uuser>({} as Uuser);



  const { data, isLoading, isError, refetch } = useQuery(['user'], () => {
    return Axios.get(`https://localhost:7060/api/User/2`)
      .then((res) => {
        console.log(res.data);
        setUser(res.data);
      });
  });

  return (
    <div className="Profile">
      <div className="user_info">
        <div className="bios_part">
          <img src="https://cdn-icons-png.flaticon.com/128/3917/3917711.png" alt="" />
          <div className="right_bios_part">
            <p><b>@{user.userName}</b> {user.firstName} {user.lastName}</p>
            <p>{user.bios}</p>
          </div>
        </div>
        <div className="buttons">
          <button>My posts</button>
          <button>My answers</button>
          <button>Liked posts</button>
        </div>
        
      </div>
      <div className="user_posts">
        <p>Ide fognak jönni a bal oldalon láthatő szűrők alapján az adott felhasználó postjai</p>
      </div>
    </div>
  );
}