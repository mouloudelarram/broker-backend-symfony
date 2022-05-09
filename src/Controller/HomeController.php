<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\UserRepository;
use App\Repository\CategorieRepository;
use App\Repository\ItemRepository;
use App\Repository\ImageRepository;

class HomeController extends AbstractController
{
    /**
     * @Route("/", name="app_home")
     */
    public function index(UserRepository $userRepository,CategorieRepository $categorieRepository, ItemRepository $itemRepository, ImageRepository $imageRepository): Response
    {
        return $this->render('home/index.html.twig', [
            'controller_name' => 'HomeController',
            'users'=> $userRepository->findAll(),
            'allUser' => $userRepository->findByRoleField('ROLE_USER'),
            'admin' => $userRepository->findByRoleField('ROLE_ADMIN'),
            'tenant' => $userRepository->findByRoleField('ROLE_TENANT'),
            'categories' => $categorieRepository->findAll(),
            'items' => $itemRepository->findAll(),
            'images' => $imageRepository->findAll(),
        ]);
    }
}
