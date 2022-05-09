<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use App\Entity\Item;
use App\Entity\Image;
use App\Entity\Categorie;
use App\Entity\Position;
use Symfony\Component\HttpFoundation\Request;

/**
 * @Route("/api", name="app_api")
 */
class ApiController extends AbstractController
{
    /**
     * @Route("/item", name="app_item_api")
     */
    public function getItems(): JsonResponse
    {
        $em = $this->getDoctrine()->getManager();
        $items = $em->getRepository(Item::class)->findAll();
        
        $data = array();
        foreach ($items as $element => $item) {
            $data[$element]['id'] = $item->getId();
            $data[$element]['label'] = $item->getLabel();
            $data[$element]['description'] = $item->getDescription();
            $data[$element]['address'] = $item->getAddress();
            $data[$element]['createdAt'] = $item->getCreatedAt();
            $data[$element]['price'] = $item->getPrice();
            $data[$element]['rooms'] = $item->getRooms();
            $data[$element]['bathrooms'] = $item->getBathrooms();
            $data[$element]['large'] = $item->getLarge();
            /* get author of this item */
                $data[$element]['author'] = $item->getAuthor()->getUsername();
                $data[$element]['authorEmail'] = $item->getAuthor()->getEmail();
                $data[$element]['authorPhone'] = $item->getAuthor()->getPhone();
            /* get categorie of this item */
                $data[$element]['categorie'] = $item->getCategorie()->getTitle();
            /* get all images of this item */
                $images = $em->getRepository(Image::class)->findBy(array('item' => $data[$element]['id']));
                $data[$element]['image']  = array();
                foreach ($images as $index => $image) {
                    $data[$element]['image'][$index]['id'] = $image->getId();
                    /* will change this to an other host */
                    $data[$element]['image'][$index]['path'] = 'http://192.168.43.185:8000/uploads/'.$image->getPath();
                }
            /* end */
        }
        return new JsonResponse($data, 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8']);
    }

    /**
     * @Route("/categorie", name="app_categorie_api")
     */
    public function getCategories(): JsonResponse
    {
        $em = $this->getDoctrine()->getManager();
        $categories = $em->getRepository(Categorie::class)->findAll();
        
        $data = array();
        foreach ($categories as $element => $categorie) {
            $data[$element]['id'] = $categorie->getId();
            $data[$element]['title'] = $categorie->getTitle();
            $data[$element]['description'] = $categorie->getDescription();
            $data[$element]['image'] = 'http://192.168.43.185:8000/uploads/'.$categorie->getImage();
        }
        return new JsonResponse($data);
    }

    /**
     * @Route("/position", name="app_position_api")
     */
    public function getPositions(): JsonResponse
    {
        $em = $this->getDoctrine()->getManager();
        $positions = $em->getRepository(Position::class)->findAll();
        
        $data = array();
        foreach ($positions as $element => $position) {
            $data[$element]['id'] = $position->getId();
            $data[$element]['latitude'] = $position->getLatitude();
            $data[$element]['longitude'] = $position->getLongitude();
        }
        return new JsonResponse($data);
    }

    /**
     * @Route("/position/{longitude}/{latitude}", name="app_addposition_api")
     */
    public function addPosition(Request $request, PositionRepository $positionRepository): JsonResponse
    {
        $longitude = $request->get('longitude');
        $latitude = $request->get('latitude');
        
        $position = new Position();
        $position->setLatitude($latitude);
        $position->setLongitude($longitude);

        $positionRepository->add($position);


    }
}
