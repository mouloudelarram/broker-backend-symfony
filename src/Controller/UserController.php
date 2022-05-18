<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\HttpFoundation\File\File;
/**
 * @Route("/user")
 */
class UserController extends AbstractController
{
    /**
     * @Route("/{role?ROLE_USER}", name="app_user_index", methods={"GET"})
     */
    public function index(Request $request, UserRepository $userRepository): Response
    {
        $role = $request->get('role');
        return $this->render('user/index.html.twig', [
            'users' => $userRepository->findAll(),
            'role' => $role,
        ]);
    }

    /**
     * @Route("/{role?ROLE_USER}/new", name="app_user_new", methods={"GET", "POST"})
     */
    public function new(Request $request, UserPasswordHasherInterface $userPasswordHasher, SluggerInterface $slugger, UserRepository $userRepository): Response
    {
        $role = $request->get('role');
        
        $user = new User();
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            /*  */
            $brochureFile = $form->get('profile')->getData();

            // this condition is needed because the 'brochure' field is not required
            // so the PDF file must be processed only when a file is uploaded
            if ($brochureFile) {
                $originalFilename = pathinfo($brochureFile->getClientOriginalName(), PATHINFO_FILENAME);
                // this is needed to safely include the file name as part of the URL
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename.'-'.uniqid().'.'.$brochureFile->guessExtension();

                // Move the file to the directory where brochures are stored
                try {
                    $brochureFile->move(
                        $this->getParameter('brochures_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                    // ... handle exception if something happens during file upload
                }

                // updates the 'brochureFilename' property to store the PDF file name
                // instead of its contents
                $user->setProfile($newFilename);/* 
                $userRepository->add($user); */
            }


            $user->setCreatedAt(new \DatetimeImmutable('now'));
            $user->setPassword(
                $userPasswordHasher->hashPassword(
                        $user,
                        $form->get('plainPassword')->getData()
                    )
                );
            $userRepository->add($user);
            return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('user/new.html.twig', [
            'user' => $user,
            'form' => $form,
            'role' => $role,
        ]);
    }

    /**
     * @Route("/{role?ROLE_ADMIN}/{id}", name="app_user_show", methods={"GET"})
     */
    public function show(User $user, Request $request): Response
    {
        $role = $request->get('role');
        
        return $this->render('user/show.html.twig', [
            'user' => $user,
            'role' => $role,
        ]);
    }

    /**
     * @Route("/{role?ROLE_ADMIN}/{id}/edit", name="app_user_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, User $user, SluggerInterface $slugger, UserPasswordHasherInterface $userPasswordHasher, UserRepository $userRepository): Response
    {
        $role = $request->get('role');
        
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user->setPassword(
                $userPasswordHasher->hashPassword(
                        $user,
                        $form->get('plainPassword')->getData()
                    )
                );

             /*  */
             $brochureFile = $form->get('profile')->getData();

             // this condition is needed because the 'brochure' field is not required
             // so the PDF file must be processed only when a file is uploaded
             if ($brochureFile) {
                 $originalFilename = pathinfo($brochureFile->getClientOriginalName(), PATHINFO_FILENAME);
                 // this is needed to safely include the file name as part of the URL
                 $safeFilename = $slugger->slug($originalFilename);
                 $newFilename = $safeFilename.'-'.uniqid().'.'.$brochureFile->guessExtension();
 
                 // Move the file to the directory where brochures are stored
                 try {
                   /*  $user->setBrochureFilename(
                        new File($this->getParameter('brochures_directory').'/'.$user->getBrochureFilename())
                    ); */
                      $brochureFile->move(
                         $this->getParameter('brochures_directory'),
                         $newFilename
                     );
                 } catch (FileException $e) {
                     // ... handle exception if something happens during file upload
                 }
 
                 // updates the 'brochureFilename' property to store the PDF file name
                 // instead of its contents
                 $user->setProfile($newFilename);/* 
                 $userRepository->add($user); */
             }

             
            $user->setCreatedAt(new \DatetimeImmutable('now'));
            $userRepository->add($user);
            return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('user/edit.html.twig', [
            'user' => $user,
            'form' => $form,
            'role' => $role,
        ]);
    }

    /**
     * @Route("/{role?ROLE_ADMIN}/{id}", name="app_user_delete", methods={"POST"})
     */
    public function delete(Request $request, User $user, UserRepository $userRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$user->getId(), $request->request->get('_token'))) {
            $userRepository->remove($user);
        }

        return $this->redirectToRoute('app_user_index', [], Response::HTTP_SEE_OTHER);
    }
}
