import {useQuery} from 'react-query'
import Axios from 'axios';
// State Imports
import { useState } from 'react';
import { useParams } from 'react-router-dom';
// Component Imports
import { Post } from '../components/Post';
// Interface Imports
import { Posts, Post as PostType } from './../../models/PostModel'
// Style Imports
import '../styles/home.css'

import { getHome } from '../services/endpointFetching';


export const Home = () => {
  const [posts, setPosts] = useState<PostType[]>([] as PostType[]);
  const { userId } = useParams();

  const { data, isLoading, isError, refetch } = useQuery(['posts', userId ?? ''], () => getHome(parseInt(userId ?? '')), {
    onSuccess: (data: PostType[]) => {
      setPosts(data);
      console.log(data)
    }
  });
  
  return (
    <div className="Home">
      {isLoading && <div>Loading...</div>}
      {isError && <div>Error fetching data</div>}
      <div>
        {posts.map((post: PostType) => (
          <Post key={post.question} {...post} />
        ))}
      </div>
    </div>
  );
}